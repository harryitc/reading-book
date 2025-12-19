import 'package:reading_book/features/home/domain/models/story.dart';

/// Mock data provider for the Explore screen
class StoryMockData {
  static const String _imageBaseUrl =
      'https://lh3.googleusercontent.com/aida-public';

  static List<Story> getAllStories() {
    return [
      Story(
        id: '1',
        title: 'Thần Đạo Đan Tôn',
        author: 'Cô Đơn Địa Phi',
        description:
            'Một vị Đan Đế trọng sinh lại, bắt đầu hành trình tu luyện lại từ đầu. Kiếp trước hắn đứng trên đỉnh cao đan đạo, nhưng võ đạo lại không trọn vẹn. Kiếp này, mang theo ký ức của Đan Đế, hắn quyết tâm song tu Đan Võ, trấn áp thiên kiêu, đạp nát hư không, thành tựu Thần Đạo Đan Tôn vô thượng!',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBBbOncZLsRDZnDmD_ri334VD-tKjI8j0vPTWaEedrTrFS7U5gRSCNlfy0k-DvV8879U_jLETIC0wSMGmUaBx3pOUKbyu0wpWi-_dRQPgP7BqwfI9zP2jYzKTFZzuIqH6Z8yuqLSDdkp8PoyDprJNKuvw712GPhGNB-JKqGXWe33BMrIHKfLxpWSrnqJnvc4BKsnDn7PAmf1sGtzDmPzRDdciSfPILhf6YsBjEVdrlrMUd8mxncK82iDgEJ69QixlcjbXtsBHRAQ-Q',
        content: '',
        genres: ['Huyền Huyễn', 'Tiên Hiệp', 'Trọng Sinh'],
        rating: 4.8,
        totalChapters: 1245,
        latestChapter: 1245,
        publishedAt: DateTime(2022, 3, 15),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '2',
        title: 'Tôi Nhận Được Hệ Thống Bất Ổn Định',
        author: 'Vũ Thần Vô Tich',
        description:
            'Một hệ thống bất ổn định xuất hiện trước mặt cậu chủ nhân của nó. Nó có thể giúp cậu trở thành người mạnh nhất, nhưng mỗi lần sử dụng đều là một cuộc cờ bạc với tử thần. Liệu cậu có dám bước vào con đường nguy hiểm này?',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8A9B',
        content: '',
        genres: ['Huyền Huyễn', 'Hệ Thống', 'Phiêu Lưu'],
        rating: 4.6,
        totalChapters: 856,
        latestChapter: 856,
        publishedAt: DateTime(2022, 5, 20),
        updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '3',
        title: 'Kiếm Tỏa Truyền Thuyết',
        author: 'Kiếm Sư Vô Hạn',
        description:
            'Một thanh kiếm huyền thoại, một bộ kỹ năng bí ẩn, một chàng trai được chọn bởi vận mệnh. Anh ta sẽ lật đổ thế giới tu tiên hay sẽ bị chìm vào đôi tay của vận mệnh?',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBfU-7vKlmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcde',
        content: '',
        genres: ['Huyền Huyễn', 'Võ Hiệp', 'Thanh Xuân'],
        rating: 4.7,
        totalChapters: 1100,
        latestChapter: 1099,
        publishedAt: DateTime(2023, 1, 10),
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '4',
        title: 'Trạng Nguyên Chi Lộ',
        author: 'Công Tử Thanh Kỳ',
        description:
            'Một thanh niên bình thường từ một thị trấn nhỏ bất ngờ nhận được một thứ sức mạnh kỳ lạ. Anh ta bắt đầu hành trình chinh phục thế giới và tìm kiếm chân lý.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8C9D',
        content: '',
        genres: ['Huyền Huyễn', 'Trọng Sinh', 'Kỳ Ảo'],
        rating: 4.5,
        totalChapters: 645,
        latestChapter: 645,
        publishedAt: DateTime(2022, 8, 15),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: StoryStatus.full,
      ),
      Story(
        id: '5',
        title: 'Thế Giới Dị Tướng',
        author: 'Quỷ Huyền Đặc Bộ',
        description:
            'Khi những sinh vật kỳ lạ xuất hiện trên trái đất, nhân loại bắt đầu một cuộc chiến sinh tồn mới. Một thanh niên bình thường sẽ trở thành chiến binh cuối cùng.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBfU-7vKlmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdf',
        content: '',
        genres: ['Sách Quỷ', 'Hành Động', 'Phiêu Lưu'],
        rating: 4.4,
        totalChapters: 520,
        latestChapter: 515,
        publishedAt: DateTime(2023, 2, 20),
        updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '6',
        title: 'Tình Yêu Vượt Thời Gian',
        author: 'Nguyên Chu Bạc Tử',
        description:
            'Một tình yêu bất diệt vượt qua mấy ngàn năm. Hai linh hồn được sự mệnh kết nối lại trong vòng trữ tình không tận cùng.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8E9F',
        content: '',
        genres: ['Tình Cảm', 'Lãng Mạn', 'Kỳ Ảo'],
        rating: 4.9,
        totalChapters: 780,
        latestChapter: 780,
        publishedAt: DateTime(2022, 11, 5),
        updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
        status: StoryStatus.full,
      ),
      Story(
        id: '7',
        title: 'Hoàng Đế Tối Cao',
        author: 'Bá Chủ Thế Giới',
        description:
            'Từ một nô lệ bị bán, anh ta trở thành Hoàng Đế Tối Cao quyền lực nhất trong vũ trụ. Câu chuyện về khát vọng, quyền lực và cô đơn của một vị vua.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBfU-7vKlmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdg',
        content: '',
        genres: ['Huyền Huyễn', 'Kỳ Ảo', 'Đen Tối'],
        rating: 4.7,
        totalChapters: 1356,
        latestChapter: 1356,
        publishedAt: DateTime(2021, 6, 10),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        status: StoryStatus.full,
      ),
      Story(
        id: '8',
        title: 'Con Đường Bất Tử',
        author: 'Độc Tôn Thanh Vân',
        description:
            'Ai nói rằng con người không thể bất tử? Một bí mật cũ từ xưa sẽ thay đổi vận mệnh của cả vũ trụ.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8G9H',
        content: '',
        genres: ['Huyền Huyễn', 'Tiên Hiệp', 'Phiêu Lưu'],
        rating: 4.6,
        totalChapters: 987,
        latestChapter: 985,
        publishedAt: DateTime(2022, 4, 18),
        updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '9',
        title: 'Vệ Thần Thần Thể',
        author: 'Thần Linh Tiên Nhân',
        description:
            'Một thứ thể chất vệ thần được sinh ra một lần trong triệu năm. Chàng trai này sẽ sử dụng nó để chinh phục bất khả thi.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBfU-7vKlmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdh',
        content: '',
        genres: ['Huyền Huyễn', 'Võ Hiệp', 'Hành Động'],
        rating: 4.8,
        totalChapters: 1123,
        latestChapter: 1120,
        publishedAt: DateTime(2022, 9, 25),
        updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '10',
        title: 'Gia Tộc Thần Quyền',
        author: 'Tộc Trưởng Vô Địch',
        description:
            'Bí mật của một gia tộc cổ xưa bị chôn vùi hàng ngàn năm. Nó sắp được khám phá và sẽ gây ra những cuộc thay đổi lớn.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8H9I',
        content: '',
        genres: ['Huyền Huyễn', 'Kỳ Ảo', 'Gia Tộc'],
        rating: 4.5,
        totalChapters: 890,
        latestChapter: 888,
        publishedAt: DateTime(2023, 3, 8),
        updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '11',
        title: 'Chúa Tể Bóng Tối',
        author: 'Đêm Tối Vô Tận',
        description:
            'Một vị chúa tể hùng mạnh từ thế giới bóng tối xuất hiện và bắt đầu thống trị. Liệu có ai có thể ngăn cản hắn?',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBfU-7vKlmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdi',
        content: '',
        genres: ['Sách Quỷ', 'Hành Động', 'Đen Tối'],
        rating: 4.3,
        totalChapters: 756,
        latestChapter: 750,
        publishedAt: DateTime(2023, 1, 20),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '12',
        title: 'Thứ Võ Công Thần Kỳ',
        author: 'Tuyệt Kỹ Tối Cao',
        description:
            'Một bộ võ công bị coi là thần thoại, lãng quên bởi thời gian. Một thanh niên vô tình tìm thấy nó và bắt đầu hành trình vô địch.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8I9J',
        content: '',
        genres: ['Võ Hiệp', 'Huyền Huyễn', 'Thanh Xuân'],
        rating: 4.6,
        totalChapters: 1034,
        latestChapter: 1032,
        publishedAt: DateTime(2022, 7, 12),
        updatedAt: DateTime.now().subtract(const Duration(hours: 10)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '13',
        title: 'Nữ Thần Trọng Sinh',
        author: 'Tiên Nữ Bất Diệt',
        description:
            'Một nữ thần bất diệt trọng sinh lại với ký ức toàn bộ về quá khứ. Lần này, cô sẽ thay đổi vận mệnh của cả vũ trụ.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBfU-7vKlmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdj',
        content: '',
        genres: ['Trọng Sinh', 'Tiên Hiệp', 'Lãng Mạn'],
        rating: 4.9,
        totalChapters: 1289,
        latestChapter: 1287,
        publishedAt: DateTime(2022, 2, 14),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '14',
        title: 'Tôn Sư Của Nhân Loại',
        author: 'Dạy Dỗ Vô Cùng',
        description:
            'Một giáo viên bí ẩn xuất hiện và giáo dạy một nhóm học sinh với những phương pháp không thể tưởng tượng được. Họ sẽ trở thành những nhân vật hùng mạnh nhất.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8J9K',
        content: '',
        genres: ['Huyền Huyễn', 'Hành Động', 'Giáo Dục'],
        rating: 4.4,
        totalChapters: 645,
        latestChapter: 640,
        publishedAt: DateTime(2023, 4, 5),
        updatedAt: DateTime.now().subtract(const Duration(hours: 7)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '15',
        title: 'Vũ Trụ Phiêu Lưu Ký',
        author: 'Sao Lệch Thập Tứ',
        description:
            'Một thanh niên bất ngờ được kéo vào một cuộc phiêu lưu xuyên vũ trụ. Anh ta sẽ gặp những người bạn, thích thú và nguy hiểm trên hành trình tìm về nhà.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuBfU-7vKlmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdk',
        content: '',
        genres: ['Khoa Học Viễn Tưởng', 'Phiêu Lưu', 'Kỳ Ảo'],
        rating: 4.7,
        totalChapters: 1567,
        latestChapter: 1560,
        publishedAt: DateTime(2021, 10, 3),
        updatedAt: DateTime.now().subtract(const Duration(days: 4)),
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '16',
        title: 'Mục Tiêu Bất Khả Thi',
        author: 'Chiến Thắng Nhất Định',
        description:
            'Mục tiêu: trở thành người mạnh nhất. Chướng ngại vật: tất cả mọi người. Cơ hội thành công: gần như không. Nhưng anh ta sẽ cố gắng dù sao.',
        coverImageUrl:
            '$_imageBaseUrl/AB6AXuCfU-7v-sKR4n5zF8X9mJ2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8K9L',
        content: '',
        genres: ['Huyền Huyễn', 'Hành Động', 'Truyền Thuyết'],
        rating: 4.8,
        totalChapters: 1198,
        latestChapter: 1195,
        publishedAt: DateTime(2022, 12, 1),
        updatedAt: DateTime.now().subtract(const Duration(hours: 9)),
        status: StoryStatus.ongoing,
      ),
    ];
  }
}
