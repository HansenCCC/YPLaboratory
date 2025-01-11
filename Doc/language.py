import os
import re
import sys

def extract_localized_strings_from_folder(folder_path):
    """
    遍历文件夹下所有 .m 文件，提取 @"xxxxx".yp_localizedString 的内容，并保存为 "xxx" = "xxx"; 格式。
    """
    if not os.path.exists(folder_path):
        print(f"路径 {folder_path} 不存在！")
        return
    
    # 用于存储所有提取的字符串
    extracted_strings = []
    
    # 正则表达式：精准匹配 @"xxxxx".yp_localizedString
    pattern = re.compile(r'@"([^"]+)"\.yp_localizedString')
    
    # 遍历文件夹下的所有 .m 文件
    for root, _, files in os.walk(folder_path):
        for file_name in files:
            if file_name.endswith(".m"):
                file_path = os.path.join(root, file_name)
                print(f"正在处理文件：{file_path}")
                try:
                    # 读取文件内容
                    with open(file_path, "r", encoding="utf-8") as file:
                        content = file.read()
                    # 提取 @"xxxxx".yp_localizedString 的内容
                    matches = pattern.findall(content)
                    # 转换为 "xxx" = "xxx"; 格式
                    formatted_matches = [f'"{match}" = "{match}";' for match in matches]
                    extracted_strings.extend(formatted_matches)
                except Exception as e:
                    print(f"处理文件 {file_path} 时出错：{e}")
    
    # 去重并排序
    extracted_strings = sorted(set(extracted_strings))
    
    # 打印结果
    if extracted_strings:
        print("提取到的字符串如下：")
        for string in extracted_strings:
            print(string)
        
        # 保存到文件
        output_path = os.path.join(folder_path, "language.strings")
        with open(output_path, "w", encoding="utf-8") as output_file:
            output_file.write("\n".join(extracted_strings))
        print(f"提取完成，结果已保存到 {output_path}")
    else:
        print("未提取到符合条件的字符串！")

# 检查是否传入了路径参数
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: python 脚本名.py 文件夹路径")
        sys.exit(1)
    
    folder_path = sys.argv[1]
    extract_localized_strings_from_folder(folder_path)
