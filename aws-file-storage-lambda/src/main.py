import os
import json
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

MOUNT_PATH = "/mnt/efs"

def handler(event, context):
    try:
        # 1. Verify mount point exists
        if not os.path.exists(MOUNT_PATH):
            return {"statusCode": 500, "body": "EFS mount path not found"}

        # 2. Perform a file operation
        file_name = event.get("file_name", "execution_log.txt")
        file_path = os.path.join(MOUNT_PATH, file_name)
        
        with open(file_path, "a") as f:
            f.write(f"Invocation {context.aws_request_id} successful.\n")

        # 3. Read back to confirm
        with open(file_path, "r") as f:
            lines = f.readlines()

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "File written to EFS",
                "path": file_path,
                "total_entries": len(lines)
            })
        }
    except Exception as e:
        logger.error(f"Error: {str(e)}")
        return {"statusCode": 500, "body": str(e)}