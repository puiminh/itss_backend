# README

# Hướng dẫn sử dụng API. Chi tiết api dùng mục đích gì xem file API Require
## GET /api/courses/recent/:user_id
- Input: user_id: số nguyên integer
- Output: [
    {
        course,
        progress
    }
]

## GET /api/courses/recommended
- Input: không
- Output: {
    data: [ recommended_courses ]
}

## GET /api/collections/recommended
- Input: Không
- Output: {
    data: [
        {
            collection,
            author,
            bookmark_collections,
            bookmark_users
        }
    ]
}

## POST /api/collections/courses
- Input: body: {
    course_id,
    collection_id
}

## POST /api/courses/duplicate/:user_id
- Input: route param: user_id: số nguyên
        body: {
           course_id
        }

## POST /api/progress/update
- Input: body: {
    user_id,
    course_id,
    vocabulary_id
}