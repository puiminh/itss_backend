json.array! @notices do |notice|
        json.partial! 'api/v1/notices/notice', notice: notice
end
