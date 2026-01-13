/// Mock story content data for reader view
/// This provides diverse story content for testing the reader feature
class MockStoryContent {
  MockStoryContent._();

  /// Get story content by story ID
  static String getContentById(String storyId) {
    return _contentMap[storyId] ?? _defaultContent;
  }

  /// Default content for stories without specific content
  static const String _defaultContent = '''
Chương 1: Khởi Đầu

Trong ánh bình minh của một ngày mới, thế giới này đang từ từ thức dậy. Những tia nắng đầu tiên len lỏi qua kẽ lá, tạo nên những đốm sáng lung linh trên mặt đất.

Câu chuyện của chúng ta bắt đầu từ một ngôi làng nhỏ nằm giữa núi non trùng điệp. Nơi đây, con người sống hài hòa với thiên nhiên, mỗi ngày trôi qua bình yên và êm đềm.

Nhưng sự bình yên ấy sắp bị phá vỡ. Một sự kiện bất ngờ sẽ thay đổi tất cả, đưa những nhân vật của chúng ta vào một cuộc phiêu lưu không thể ngờ tới.

Chương 2: Hành Trình

Ngày hôm sau, mọi thứ bắt đầu thay đổi. Những dấu hiệu kỳ lạ xuất hiện khắp nơi, báo hiệu rằng một điều gì đó lớn lao sắp xảy ra.

Nhân vật chính của chúng ta, một người trẻ tuổi với ước mơ lớn lao, quyết định lên đường tìm kiếm sự thật. Họ không biết rằng, hành trình này sẽ đưa họ đến những nơi xa xôi, gặp gỡ những con người đặc biệt, và học được những bài học quý giá về cuộc sống.

Trên đường đi, họ phải đối mặt với nhiều thử thách. Mỗi thử thách là một cơ hội để họ trưởng thành, để họ hiểu rõ hơn về bản thân và thế giới xung quanh.

(Nội dung đang được phát triển...)
''';

  /// Story content map by ID
  static final Map<String, String> _contentMap = {
    '1': _theLostKingdomContent,
    '2': _whispersInDarkContent,
    '3': _loveInCityContent,
    '4': _timeTravelerContent,
    '5': _dragonLegacyContent,
  };

  /// The Lost Kingdom - Full content
  static const String _theLostKingdomContent = '''
Chương 1: Vương Quốc Mất Tích

Ngày xưa, trong những trang sử cổ, có một vương quốc hùng mạnh nằm giữa những dãy núi cao và những thung lũng xanh tươi. Vương quốc này được gọi là Aldoria, nơi mà ma thuật và khoa học cùng tồn tại, nơi mà con người và các sinh vật huyền bí sống chung với nhau trong hòa bình.

Nhà vua Aldric III là một vị vua hiền minh và khôn ngoan. Ngài đã cai trị vương quốc với tình yêu thương và công bằng suốt ba mươi năm. Dưới sự lãnh đạo của ngài, Aldoria trở thành một trong những vương quốc thịnh vượng nhất trong vùng.

Nhưng một ngày nọ, mọi thứ thay đổi. Một cơn sương mù kỳ lạ bao phủ toàn bộ vương quốc. Cơn sương không tan đi, ngày càng dày đặc hơn. Người dân bắt đầu lo lắng, và những lời đồn đại bắt đầu lan truyền.

"Đây là dấu hiệu của một lời nguyền cổ xưa," các pháp sư già cả nói. "Một lời nguyền mà chúng ta tưởng đã bị lãng quên từ lâu."

Nhà vua triệu tập hội đồng khẩn cấp. Trong căn phòng họp lớn, những bậc thầy về ma thuật, các chiến binh dũng cảm, và các học giả uyên bác đều có mặt.

"Chúng ta phải hành động," nhà vua tuyên bố. "Phải tìm ra nguồn gốc của cơn sương mù này và ngăn chặn nó trước khi quá muộn."

Một thanh niên bước ra từ đám đông. Anh là Kael, con trai của đại tướng quân và cũng là một trong những chiến binh trẻ tuổi tài năng nhất của vương quốc.

"Tâu bệ hạ," Kael nói với giọng quyết đoán. "Con xin phép được dẫn đầu đoàn thám hiểm để tìm kiếm nguồn gốc của cơn sương mù này."

Chương 2: Cuộc Thám Hiểm Bắt Đầu

Sáng hôm sau, Kael cùng với một nhóm gồm năm người khác bắt đầu hành trình của họ. Trong nhóm có Lyra, một nữ pháp sư trẻ với khả năng điều khiển ánh sáng; Thorne, một chiến binh kỳ cựu với kinh nghiệm chiến đấu phong phú; Mira, một thầy thuốc tài năng; Finn, một cung thủ bách phát bách trúng; và Elder Sage, một pháp sư già với kiến thức sâu rộng về lịch sử.

Họ đi theo con đường mòn cổ xưa dẫn ra khỏi thành phố, đi sâu vào khu rừng rậm rạp nơi ít người dám bước chân vào. Cơn sương mù dày đặc hơn khi họ tiến sâu hơn vào rừng.

"Hãy cẩn thận," Elder Sage cảnh báo. "Khu rừng này ẩn chứa nhiều nguy hiểm. Không chỉ có các sinh vật hoang dã, mà còn có những thứ tối tăm hơn nhiều."

Họ đi được nửa ngày thì trời bắt đầu tối. Quyết định cắm trại qua đêm, họ tìm một khoảng đất trống và đốt lửa. Ánh lửa nhảy múa trong đêm tối, tạo nên những bóng đen kỳ lạ trên những thân cây xung quanh.

"Tôi nghe thấy những câu chuyện về khu rừng này," Lyra nói trong khi sưởi ấm bên đống lửa. "Người ta nói rằng đây từng là nơi của một nền văn minh cổ xưa, một nền văn minh có sức mạnh phi thường."

Elder Sage gật đầu. "Đúng vậy. Nền văn minh Eldrith. Họ đã biến mất cách đây hơn một nghìn năm, không để lại dấu vết nào ngoại trừ những tàn tích và truyền thuyết."

"Và người ta cũng nói rằng họ đã tạo ra một thứ gì đó," Thorne nói thêm. "Một thứ có sức mạnh ghê gớm. Một thứ đã dẫn đến sự sụp đổ của họ."

Câu nói của Thorne khiến tất cả im lặng. Trong đêm tối, tiếng gió thổi qua những tán lá tạo ra âm thanh rên rỉ như những lời thì thầm ma quái.

Đột nhiên, Finn đứng dậy. "Có gì đó đang tiến lại gần," anh nói, tay đặt lên cây cung.

Chương 3: Cuộc Gặp Gỡ Đầu Tiên

Từ trong bóng tối, một hình dáng xuất hiện. Đó là một sinh vật cao lớn, với đôi mắt phát sáng màu xanh lục trong đêm tối. Nó bước từng bước một đến gần, và ánh lửa chiếu rõ hình dáng của nó.

Đó là một con sói khổng lồ, to gấp ba lần con sói thường. Bộ lông của nó có màu bạc, lấp lánh dưới ánh trăng. Nhưng điều kỳ lạ nhất là nó không tỏ ra hung dữ. Thay vào đó, nó ngồi xuống và nhìn họ với ánh mắt thông minh.

"Đừng di chuyển," Elder Sage thì thầm. "Đây không phải là một con sói thường. Đây là một Vệ Thủ - một sinh vật được tạo ra bởi người Eldrith để bảo vệ khu rừng."

Con sói mở miệng và phát ra một âm thanh kỳ lạ. Không phải là tiếng sủa hay tiếng tru, mà là một thứ giống như giọng nói của con người, nhưng không phải ngôn ngữ mà họ có thể hiểu.

Lyra bước tới phía trước. Cô ta giơ tay ra và tập trung ma lực. Một quả cầu ánh sáng nhỏ xuất hiện trong lòng bàn tay cô, phát ra ánh sáng ấm áp.

Con sói nhìn quả cầu ánh sáng, sau đó nhìn vào mắt Lyra. Một khoảnh khắc sau, nó đứng dậy và bắt đầu đi về phía trước, rồi dừng lại và quay đầu nhìn họ, như thể muốn họ theo.

"Nó muốn dẫn chúng ta đi đâu đó," Kael nói. "Chúng ta có nên tin nó không?"

Elder Sage suy nghĩ một lúc. "Các Vệ Thủ không bao giờ làm hại những người vô tội. Nếu nó muốn dẫn chúng ta đi, thì có lẽ chúng ta nên theo."

Họ thu dọn đồ đạc và dập tắt lửa. Con sói lớn dẫn họ đi sâu hơn vào rừng, đi theo những con đường mà họ không bao giờ tìm thấy nếu không có nó.

Sau khoảng một giờ đi bộ, họ đến một khoảng rừng rậm. Con sói dừng lại trước một bức tường đá lớn phủ đầy rêu và dây leo. Nó đặt chân lên bức tường và cào, phát ra âm thanh lạo xạo.

Thorne tiến lại gần và xem xét bức tường. "Đây không phải là một hòn đá tự nhiên," anh nói. "Đây là một công trình kiến trúc. Có điều gì đó ở phía sau."

Họ bắt đầu dọn dẹp dây leo và rêu. Sau một lúc, họ phát hiện ra những chữ khắc cổ xưa trên bề mặt đá.

"Đây là chữ viết của người Eldrith," Elder Sage nói với sự phấn khích trong giọng nói. "Tôi có thể đọc được một số. Nó nói về... một cánh cổng. Một cánh cổng dẫn đến trái tim của vương quốc cổ xưa."

"Và làm thế nào để mở nó?" Kael hỏi.

Elder Sage tiếp tục nghiên cứu những chữ khắc. "Nó yêu cầu... ánh sáng tinh khiết. Ánh sáng không bị ô nhiễm bởi bóng tối."

Tất cả mọi người nhìn sang Lyra. Cô ta bước tới phía trước, tập trung ma lực của mình. Quả cầu ánh sáng trong tay cô bắt đầu phát sáng rực rỡ hơn, ngày càng sáng hơn cho đến khi nó chiếu sáng cả khu vực xung quanh như ban ngày.

Lyra đặt quả cầu ánh sáng vào một hốc trống trên bức tường. Ngay lập tức, toàn bộ bức tường bắt đầu phát sáng. Những đường nét ánh sáng chạy khắp bề mặt, tạo nên những hình vẽ và ký tự phức tạp.

Sau đó, với tiếng rền vang, bức tường bắt đầu mở ra, để lộ một lối vào tối tăm phía sau.

Con sói quay lại nhìn họ một lần nữa, rồi biến mất vào bóng tối của khu rừng. Nhiệm vụ của nó đã hoàn thành.

"Đây rồi," Kael nói, rút kiếm ra khỏi vỏ. "Hãy xem những gì đang chờ đợi chúng ta bên trong."

Họ thắp đuốc và bước vào lối vào tối tăm. Phía trước họ là những bậc thang đá dẫn xuống sâu dưới lòng đất. Mỗi bước chân của họ vang lên trong sự im lặng gần như tuyệt đối.

Cuộc phiêu lưu thực sự của họ bây giờ mới bắt đầu.

(Còn tiếp...)
''';

  /// Whispers in the Dark content
  static const String _whispersInDarkContent = '''
Chương 1: Tiếng Thì Thầm Trong Đêm

Thành phố Ravenwood luôn được bao phủ trong bóng đêm dày đặc. Không phải vì trời tối, mà vì những tòa nhà cao chọc trời chặn hết ánh sáng mặt trời. Nơi đây, con người sống trong những con phố nhỏ hẹp, nơi ánh đèn neon là nguồn sáng duy nhất.

Nó bắt đầu với một tiếng thì thầm. Một tiếng thì thầm mà chỉ một người có thể nghe thấy - detective Maya Chen. Cô là một trong những thám tử tài năng nhất của thành phố, được biết đến với khả năng giải quyết những vụ án phức tạp nhất.

Đêm nay, Maya đang ngồi trong văn phòng nhỏ của mình, xem xét những tài liệu về một vụ án mất tích bí ẩn. Năm người đã biến mất trong vòng hai tuần, tất cả đều không để lại dấu vết.

Đột nhiên, cô nghe thấy nó. Một tiếng thì thầm nhẹ nhàng, như gió thổi qua. Nhưng không có gió nào trong căn phòng kín này.

"Tìm kiếm sự thật..." tiếng thì thầm nói. "Ở nơi ánh sáng không thể chạm đến..."

Maya nhảy dựng lên, nhìn quanh phòng. Không có ai cả. Cô lắc đầu, nghĩ rằng mình đang làm việc quá nhiều.

Nhưng tiếng thì thầm quay trở lại. Lần này rõ ràng hơn.

"Khu phố cũ... tòa nhà bỏ hoang... bí mật nằm ở đó..."

Maya cảm thấy một cơn lạnh chạy dọc sống lưng. Cô biết về khu phố cũ. Đó là nơi bị bỏ hoang từ lâu, nơi mà ngay cả những tên tội phạm cứng nhất cũng không dám bước chân vào.

Chương 2: Cuộc Điều Tra

Sáng hôm sau, Maya quyết định đến khu phố cũ. Cô không nói với ai về tiếng thì thầm, sợ họ sẽ nghĩ cô đang mất trí.

Khu phố cũ nằm ở rìa thành phố, một khu vực mà thời gian dường như đã dừng lại. Những tòa nhà cũ kỹ đứng nghiêng ngả, cửa sổ vỡ, tường bong tróc. Không khí ở đây nặng nề và u ám.

Maya bước cẩn thận qua những đống gạch vụn và rác rưởi. Cô tìm kiếm bất kỳ dấu hiệu nào có thể liên quan đến những người mất tích.

Khi đi sâu vào khu phố, cô nhận ra một điều kỳ lạ. Mặc dù nơi này bị bỏ hoang, nhưng có những dấu hiệu cho thấy đã có người hoạt động gần đây. Những vết chân mới trên bụi, những mảnh vải bị xé toạc, và thứ kỳ lạ nhất - những ký hiệu được vẽ trên tường bằng một thứ gì đó có màu đỏ sẫm.

Maya chụp ảnh những ký hiệu và gửi cho một người bạn, một giáo sư chuyên về biểu tượng học cổ đại.

Không lâu sau, cô nhận được phản hồi. "Maya, những ký hiệu này thuộc về một giáo phái bí ẩn đã tuyệt chủng từ hàng trăm năm trước. Họ tin vào việc mở cánh cổng đến một thế giới khác. Đây không phải là điều tốt. Hãy cẩn thận."

Trước khi Maya kịp trả lời, cô nghe thấy tiếng thì thầm lại.

"Đi xuống... bên dưới... sự thật ở phía dưới..."

Maya nhìn xuống chân mình. Cô đang đứng trước một tòa nhà cũ kỹ với một cửa hầm đã mở. Những bậc thang dẫn xuống bóng tối.

Cô rút súng và bật đèn pin. Từng bước chậm rãi, cô đi xuống những bậc thang đá ẩm ướt và trơn trượt.

Ở dưới đáy, cô tìm thấy một căn phòng lớn. Và trong đó, một cảnh tượng làm cô kinh hoàng.

Năm người mất tích đều ở đây. Họ không chết, nhưng họ đang ngồi thành vòng tròn, mắt nhắm lại, môi miệng di động như thể đang thì thầm điều gì đó.

Ở giữa vòng tròn là một ký hiệu lớn được vẽ bằng phấn trắng. Và từ ký hiệu đó, một thứ gì đó đang phát sáng yếu ớt.

Maya tiến lại gần, cố gắng đánh thức một người trong số họ. Nhưng không có phản ứng. Họ dường như đang ở trong một trạng thái xuất thần sâu.

Đột nhiên, tất cả mọi người đồng thời mở mắt. Nhưng đó không phải là đôi mắt của họ. Đó là những đôi mắt đen tuyền, không có đáy.

Và họ đồng thanh nói với một giọng không phải của con người:

"Chào mừng, detective. Chúng tôi đã chờ đợi cô."

(Còn tiếp...)
''';

  /// Love in the City content
  static const String _loveInCityContent = '''
Chương 1: Thành Phố Của Những Ước Mơ

New Haven là một thành phố không bao giờ ngủ. Ánh đèn luôn sáng, đường phố luôn nhộn nhịp, và mọi người luôn vội vã. Đây là nơi mà những ước mơ được theo đuổi, nơi mà cuộc sống diễn ra với tốc độ chóng mặt.

Emma Richardson vừa mới chuyển đến thành phố này hai tháng trước. Cô là một kiến trúc sư trẻ đầy tham vọng, đến New Haven với hy vọng tìm được cơ hội để khẳng định tài năng của mình.

Mỗi sáng, cô thức dậy trong căn hộ nhỏ của mình ở tầng 15, nhìn ra khung cảnh thành phố tấp nập phía dưới. Mỗi đêm, cô làm việc muộn tại văn phòng, vẽ những bản thiết kế cho những tòa nhà mà cô hy vọng một ngày nào đó sẽ được xây dựng.

Cuộc sống của Emma đơn điệu và lặp lại. Công việc, về nhà, ngủ, và lặp lại. Cô không có thời gian cho những mối quan hệ cá nhân. Tình yêu, với cô, là một điều xa xỉ mà cô không thể đủ khả năng.

Nhưng cuộc sống có một cách thú vị để thay đổi kế hoạch.

Một buổi tối mưa, khi Emma đang vội vã chạy về nhà sau giờ làm việc, cô va phải một người đàn ông. Cả hai đều ngã xuống vũng nước, tài liệu và hồ sơ văng ra khắp nơi.

"Ôi, xin lỗi!" Emma vội vàng nói, cố gắng thu gom giấy tờ của mình.

"Không, tôi mới phải xin lỗi," người đàn ông nói. "Tôi không nhìn đường."

Khi Emma nhìn lên, cô thấy một người đàn ông khoảng ba mươi tuổi, với đôi mắt ấm áp và nụ cười thân thiện. Anh ta đang cầm một hộp bánh đã bị rơi xuống đất.

"Ồ không, bánh của anh," Emma nói, cảm thấy tồi tệ.

"Không sao," anh ta cười. "Tôi có thể mua thêm. Nhưng những tài liệu của cô có ổn không?"

Emma kiểm tra nhanh. Một số giấy bị ướt nhưng không có gì nghiêm trọng. "Tôi nghĩ là được. Cảm ơn anh đã hỏi."

Họ đứng dậy, lau bụi nước khỏi quần áo. Một khoảnh khắc im lặng awkward.

"Tôi là Alex," anh ta giới thiệu, đưa tay ra.

"Emma," cô bắt tay anh. "Rất vui được gặp anh. Mặc dù hoàn cảnh hơi... kỳ lạ."

Alex cười. "Đúng vậy. Nhưng có lẽ vũ trụ đang cố nói với chúng ta điều gì đó."

Emma cười khẽ, nghĩ rằng đó chỉ là một câu nói đùa. Nhưng khi cô nhìn vào mắt Alex, cô cảm thấy một điều gì đó khác thường. Một kết nối, một sức hút mà cô không thể giải thích.

"Để tôi mua cho cô một tách cà phê để bù đắp," Alex đề nghị. "Có một quán cà phê tuyệt vời ở góc phố."

Emma nhìn đồng hồ. Đã muộn, và cô còn nhiều việc phải làm. Nhưng không hiểu sao, cô thấy mình gật đầu.

"Được thôi. Một tách cà phê nhanh."

Chương 2: Những Khoảnh Khắc Nhỏ

Quán cà phê nhỏ ấm cúng với ánh đèn vàng và mùi cà phê thơm ngát. Emma và Alex ngồi bên cửa sổ, nhìn ra con phố mưa.

"Vậy cô làm gì ở New Haven?" Alex hỏi, nhấp một ngụm cà phê.

"Tôi là kiến trúc sư," Emma trả lời. "Tôi vừa mới chuyển đến đây. Còn anh?"

"Tôi là đầu bếp," Alex nói với niềm tự hào. "Tôi có một nhà hàng nhỏ ở khu phố cũ. Đó là lý do tại sao tôi mua bánh - đang thử một công thức mới."

Emma quan tâm ngay. "Một nhà hàng à? Tôi rất thích ẩm thực. Nhưng với công việc, tôi hiếm khi có thời gian để nấu ăn hay đi ăn ngoài."

"Đó là một tội ác," Alex cười. "Ẩm thực là một trong những niềm vui lớn nhất của cuộc sống. Cô không nên bỏ qua nó."

Họ nói chuyện, và Emma ngạc nhiên khi nhận ra rằng cô đang thật sự thích cuộc trò chuyện này. Alex dễ nói chuyện, hài hước, và có một cái nhìn tích cực về cuộc sống mà cô đã không gặp được ở New Haven.

"Cô biết không," Alex nói sau một lúc. "Tôi tin rằng cuộc sống không chỉ là về công việc và thành công. Đó cũng là về những khoảnh khắc nhỏ - một tách cà phê tốt, một cuộc trò chuyện hay, một buổi tối mưa..."

Emma cảm động bởi lời nói của anh. Trong suốt hai tháng qua, cô đã quên mất điều đó. Cô đã quá tập trung vào sự nghiệp đến nỗi quên mất việc sống.

"Anh nói đúng," cô nói nhẹ nhàng. "Tôi nghĩ tôi cần nhắc nhở bản thân về điều đó nhiều hơn."

"Vậy thì hãy để tôi giúp cô," Alex cười. "Tôi sẽ dạy cô cách tận hưởng những khoảnh khắc nhỏ. Bắt đầu bằng bữa tối tại nhà hàng của tôi. Cuối tuần này, cô có rảnh không?"

Emma do dự. Cô có một deadline vào đầu tuần sau. Nhưng khi nhìn vào mắt Alex, cô thấy mình muốn nói có.

"Được thôi. Tôi rất mong chờ."

(Còn tiếp...)
''';

  /// The Time Traveler content
  static const String _timeTravelerContent = '''
Chương 1: Máy Thời Gian

Năm 2050, nhân loại đã đạt được nhiều thành tựu khoa học phi thường. Nhưng không có gì vĩ đại bằng phát minh của Giáo sư Chen - một chiếc máy có thể đi xuyên thời gian.

Điều đặc biệt là Giáo sư Chen không phải là một nhà khoa học nổi tiếng. Ông chỉ là một người đàn ông già sống đơn độc trong một phòng thí nghiệm nhỏ ở rìa thành phố. Trong hơn ba mươi năm, ông đã dành cả cuộc đời cho việc nghiên cứu lý thuyết về thời gian.

"Thời gian không phải là tuyến tính như chúng ta nghĩ," ông thường nói với bản thân trong những đêm dài làm việc. "Nó là một mạng lưới phức tạp, nơi quá khứ, hiện tại, và tương lai đều tồn tại đồng thời."

Và rồi một ngày, sau vô số lần thất bại, ông đã thành công.

Chiếc máy không lớn như trong những bộ phim khoa học viễn tưởng. Nó chỉ là một chiếc hộp nhỏ với nhiều dây điện và màn hình kỹ thuật số. Nhưng khi Giáo sư Chen kích hoạt nó lần đầu tiên, mọi thứ xung quanh ông bắt đầu biến đổi.

Ánh sáng chói lòa. Một cảm giác choáng váng. Và rồi...

Ông thấy mình đứng ở cùng một vị trí, nhưng mọi thứ đã khác. Phòng thí nghiệm không còn nữa. Thay vào đó là một cánh đồng xanh tươi dưới bầu trời trong xanh.

Ông đã quay ngược thời gian về một trăm năm.

Chương 2: Những Hậu Quả

Giáo sư Chen đã nghiên cứu đủ về lý thuyết thời gian để biết nguy hiểm của việc thay đổi quá khứ. Mọi hành động nhỏ nhất đều có thể tạo ra hiệu ứng domino, thay đổi toàn bộ dòng thời gian.

Vì vậy, trong chuyến đi đầu tiên, ông chỉ quan sát. Ông nhìn ngôi làng nhỏ ở xa, nhìn những người dân sống cuộc sống đơn giản của họ. Mọi thứ trông thật bình yên và trong sáng, khác xa với thế giới công nghiệp hóa mà ông đến từ.

Sau một giờ, ông quay trở về hiện tại. Mọi thứ vẫn như cũ. Phòng thí nghiệm vẫn ở đó, cũng như tất cả những ghi chép của ông.

"Nó hoạt động!" ông reo lên, không thể tin được. "Tôi đã làm được!"

Nhưng thành công này mang theo một vấn đề. Giáo sư Chen biết rằng ông không thể giữ phát minh này cho riêng mình. Nó quá quan trọng, quá mạnh mẽ. Nhưng nếu nó rơi vào tay sai người, hậu quả sẽ thảm khốc.

Trong những ngày sau, ông cân nhắc các lựa chọn. Công bố phát minh? Giữ bí mật? Hay phá hủy nó?

Quyết định trở nên rõ ràng hơn khi một ngày nọ, có người gõ cửa phòng thí nghiệm.

Đó là một phụ nữ trẻ, mặc vest đen chỉn chu, với một chiếc cặp da.

"Giáo sư Chen," cô nói với nụ cười lạnh lùng. "Chúng tôi đã nghe về công việc của ông. Và chúng tôi rất quan tâm."

"Các bà là ai?" ông hỏi, cảm thấy không yên.

"Chúng tôi đại diện cho một tổ chức," cô trả lời mơ hồ. "Một tổ chức có rất nhiều nguồn lực và rất nhiều... ảnh hưởng. Chúng tôi muốn đầu tư vào nghiên cứu của ông."

Giáo sư Chen biết ngay đây là mối nguy hiểm. "Tôi không bán nghiên cứu của mình."

Nụ cười của người phụ nữ không đổi, nhưng ánh mắt cô trở nên lạnh lẽo hơn. "Chúng tôi không hỏi ông, Giáo sư. Chúng tôi sẽ có được nó, dù ông có muốn hay không."

Đêm đó, Giáo sư Chen đóng gói mọi thứ. Ông biết mình phải chạy, phải ẩn náu. Nhưng trước khi rời đi, ông đã đưa ra một quyết định.

Ông sẽ sử dụng máy thời gian một lần nữa. Không phải để trốn tránh, mà để tìm giải pháp. Ông sẽ đi về quá khứ, tìm những người có thể giúp ông bảo vệ phát minh này.

Và vì vậy, cuộc phiêu lưu xuyên thời gian thực sự bắt đầu.

(Còn tiếp...)
''';

  /// Dragon's Legacy content
  static const String _dragonLegacyContent = '''
Chương 1: Di Sản Của Rồng

Ngàn năm trước, rồng từng bay trên bầu trời. Chúng là những sinh vật hùng mạnh và thông minh, được con người kính sợ và tôn thờ. Mỗi con rồng đại diện cho một yếu tố: lửa, nước, đất, và không khí.

Nhưng rồi một ngày, chúng biến mất. Không ai biết tại sao hay đi đâu. Chỉ còn lại những truyền thuyết và những tàn tích của thời đại vàng son đó.

Aria lớn lên nghe những câu chuyện về rồng. Bà của cô thường kể cho cô nghe về thời kỳ mà rồng và người sống hòa bình bên nhau. Nhưng Aria, giống như hầu hết mọi người, nghĩ rằng đó chỉ là những câu chuyện thần thoại.

Cho đến ngày cô tìm thấy quả trứng.

Aria là một thợ săn, sống trong một ngôi làng nhỏ ở chân núi. Công việc của cô là đi săn trong rừng để kiếm sống. Một ngày, trong khi theo dõi một con nai, cô lạc vào một khu vực của rừng mà cô chưa từng đến.

Đó là một hang động lớn, ẩn kín sau một thác nước. Bên trong, mọi thứ đều phủ đầy pha lê và đá quý, lấp lánh trong ánh sáng yếu ớt lọt qua kẽ đá.

Và ở trung tâm của hang động, trên một bệ đá, là một quả trứng lớn. Nó to bằng cái thùng, với vỏ màu đỏ rực như ngọn lửa, có những đường vân vàng chạy khắp bề mặt.

Aria tiến lại gần, bị mê hoặc. Cô đưa tay chạm vào quả trứng, và ngay lập tức cảm thấy một luồng năng lượng ấm áp chạy qua người.

Quả trứng bắt đầu nứt.

Aria nhảy lùi, kinh hoàng và hồi hộp. Những vết nứt lan rộng khắp vỏ trứng, ánh sáng rực rỡ thoát ra từ bên trong.

Và rồi, với một tiếng kêu the thé, một sinh vật nhỏ bò ra.

Đó là một con rồng. Một con rồng con.

Nó có thân hình nhỏ như một con mèo, với đôi cánh nhỏ xíu và đuôi dài. Lớp vảy của nó màu đỏ sáng, lấp lánh dưới ánh sáng. Đôi mắt vàng của nó nhìn thẳng vào Aria với trí thông minh không thuộc về một sinh vật mới sinh.

"Người..." một giọng nói vang lên trong đầu Aria. Không phải bằng âm thanh, mà bằng suy nghĩ. "Người là ai?"

Aria choáng váng. "Tôi... tôi là Aria. Người có thể nói chuyện?"

"Rồng luôn có thể giao tiếp," giọng nói trả lời. "Ta là Ignis, con của Flameheart, rồng lửa vĩ đại cuối cùng."

"Nhưng... rồng đã biến mất từ lâu..."

"Đúng vậy," Ignis nói, bước lại gần Aria. "Và ta là con cuối cùng. Mẹ ta đã ẩn ta ở đây trước khi ra đi. Giờ đây, ta đã thức dậy. Và người, Aria, là người đã đánh thức ta."

Chương 2: Liên Kết

Aria đưa Ignis về ngôi làng của mình, giấu con rồng con trong nhà. Cô biết rằng nếu mọi người phát hiện, sẽ xảy ra hỗn loạn. Một số có thể sợ hãi, một số có thể tham lam muốn lợi dụng.

Trong những ngày đầu, Aria học được nhiều về Ignis. Con rồng con không chỉ có thể giao tiếp bằng suy nghĩ, mà còn có thể hiểu biết về lịch sử cổ xưa - những gì được truyền lại cho nó từ mẹ nó.

"Rồng không biến mất," Ignis giải thích một đêm. "Chúng ta bị đuổi đi. Một nghìn năm trước, loài người phát triển một loại ma thuật đen tối - một loại có thể kiểm soát rồng. Để bảo vệ chúng tôi, các rồng già cả đã quyết định rời khỏi thế giới này."

"Rời đi đâu?" Aria hỏi.

"Vào thế giới của rồng - một chiều không gian khác, nơi mà loài người không thể chạm đến. Nhưng mẹ ta tin rằng một ngày nào đó, rồng và người có thể sống hòa bình lại. Vì vậy, bà đã để lại ta, với hy vọng rằng ta sẽ là cầu nối."

"Nhưng tại sao bây giờ? Tại sao tôi?"

Ignis nhìn vào mắt Aria. "Bởi vì thế giới đang gặp nguy hiểm. Ma thuật đen tối đó đã quay trở lại. Và lần này, mục tiêu không phải là rồng, mà là chính loài người."

Aria cảm thấy một cơn lạnh chạy dọc sống lưng. "Nguy hiểm gì?"

"Có một tổ chức bí mật, những người đã giữ gìn ma thuật đen tối suốt một nghìn năm. Họ đã chờ đợi, chuẩn bị. Và giờ đây, họ đã đủ mạnh để thực hiện kế hoạch của họ - chinh phục toàn bộ thế giới."

"Vậy ta phải làm gì?"

"Ta cần trở nên mạnh mẽ hơn. Và người cần học cách trở thành Đại sứ Rồng - một người có thể kết nối với sức mạnh của rồng. Chỉ có một Đại sứ Rồng và một con rồng mới có thể đánh bại ma thuật đen tối."

Aria nhìn con rồng con nhỏ bé trước mặt. Cô cảm thấy sự nặng nề của trách nhiệm. Cô chỉ là một thợ săn đơn giản. Làm sao cô có thể đối đầu với một mối đe dọa đến toàn bộ thế giới?

Nhưng khi cô nhìn vào đôi mắt của Ignis, cô thấy niềm tin và quyết tâm. Và cô biết rằng, dù có khó khăn đến đâu, cô không thể từ chối.

"Được rồi," cô nói. "Ta sẽ làm. Ta sẽ trở thành Đại sứ Rồng. Hãy dạy ta."

Ignis gật đầu, và một tia lửa nhỏ xuất hiện xung quanh người Aria. Đó là khởi đầu của liên kết - sự kết nối giữa một người và một rồng.

Cuộc hành trình của họ để cứu thế giới bắt đầu từ đây.

(Còn tiếp...)
''';
}
