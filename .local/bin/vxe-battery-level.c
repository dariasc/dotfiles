#include <hidapi/hidapi.h>
#include <stdio.h>

#define WRITE_REPORT_SIZE 17
#define READ_REPORT_SIZE 16
#define TIMEOUT 1000
#define PRODUCT_IDS_COUNT 1

int vendor_id = 0x373b;
int product_ids[PRODUCT_IDS_COUNT] = {0x1085};
int usage_page = 0xff04;
unsigned char get_battery_level_command[WRITE_REPORT_SIZE] = {
0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x49};

int main() {
  if (hid_init()) {
    fprintf(stderr, "failed to initialize HIDAPI\n");
    return -1;
  }

  hid_device *device;
  {
    struct hid_device_info *devs, *cur_dev;
    for (int product_index = 0; product_index < PRODUCT_IDS_COUNT;
         product_index++) {
      devs = hid_enumerate(vendor_id, product_ids[product_index]);
      if (devs) {
        cur_dev = devs;
        while (cur_dev) {
          if (cur_dev->usage_page == usage_page) {
            device = hid_open_path(cur_dev->path);
            break;
          }
          cur_dev = cur_dev->next;
        }
        if (device) {
          break;
        }
      }
    }
  }

  if (!device) {
    fprintf(stderr, "failed to open device\n");
    hid_exit();
    return -1;
  }

  int return_value = 0;
  int res = hid_write(device, get_battery_level_command,
                  sizeof(get_battery_level_command));
  if (res == -1) {
    fprintf(stderr, "Failed to write: %ls\n", hid_error(device));
    return_value = 1;
  } else {
    unsigned char read_buf[READ_REPORT_SIZE];
    res = hid_read_timeout(device, read_buf, sizeof(read_buf), TIMEOUT);
    if (res == 0) {
      fprintf(stderr, "read timed out\n");
      return_value = 1;
    } else if (res == -1) {
      fprintf(stderr, "failed to read: %ls\n", hid_error(device));
      return_value = 1;
    } else {
      int battery_level = read_buf[6], charging = read_buf[7];
      if (battery_level == 0) {
        return_value = 1;
      } else if (charging) {
        printf("{\"text\": \"%d%\", \"class\": \"charging\" }\n", battery_level);
      } else {
        printf("{\"text\": \"%d%\"}\n", battery_level);
      }
    }
  }

  hid_close(device);
  hid_exit();
  return return_value;
}

