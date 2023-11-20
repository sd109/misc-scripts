import sys, openstack

# Initialize and turn on debug logging
openstack.enable_logging(debug=False)

# Initialize connection
cloud = openstack.connect()
user_id = cloud.current_user_id

# List volumes
volumes = list(cloud.block_storage.volumes(status='Available', user_id=user_id))
N = len(volumes)
ans = input(f"Found {N} volumes to be deleted - do you want to continue? (Y/n) ")
if ans.lower() != "y":
    print("Aborting.")
    sys.exit()
for i, v in enumerate(volumes):
    print(f"({i+1}/{N}) Deleting volume: {v.name}")
    try:
        cloud.block_storage.delete_volume(v)
    except openstack.exceptions.BadRequestException:
        print("  Failed to delete volume", v.name)