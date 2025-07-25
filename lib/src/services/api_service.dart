final data = [
  {"title": "افطار", "ets": "قلوب محسنة", "done": 56.0,"details":"إفطار الإحسان يهدف بشكل كامل للفئات المحتاجة في رمضان من خلال جمع التبرعات وتنظيم عملية التحضير والتوزيع.","audiance":"الأسر ذات الدخل المحدود في الأحياء ذات الاحتياجات الخاصة خلال شهر رمضان."},
  {"title": "كفالة يتيم", "ets": "قلوب محسنة", "done": 67.0, "details":"كفالة يتيم تهدف إلى توفير مساعدة للفئات المحتاجة في رمضان من خلال جمع التبرعات وتنظيم عملية التحضير والتوزيع.", "audiance":"الأسر ذات الدخل المحدود في الأحياء ذات الاحتياجات الخاصة خلال شهر رمضان."},
  {"title": "كفالة يتيم", "ets": "قلوب محسنة", "done": 86.0, "details":"كفالة يتيم تهدف إلى توفير مساعدة للفئات المحتاجة في رمضان من خلال جمع التبرعات وتنظيم عملية التحضير والتوزيع.", "audiance":"الأسر ذات الدخل المحدود في الأحياء ذات الاحتياجات الخاصة خلال شهر رمضان."},
  {"title": "افطار", "ets": "قلوب محسنة", "done": 34.0, "details":"إفطار الإحسان يهدف بشكل كامل للفئات المحتاجة في رمضان من خلال جمع التبرعات وتنظيم عملية التحضير والتوزيع.", "audiance":"الأسر ذات الدخل المحدود في الأحياء ذات الاحتياجات الخاصة خلال شهر رمضان."},
  {"title": "كفالة يتيم", "ets": "قلوب محسنة", "done": 45.0, "details":"كفالة يتيم تهدف إلى توفير مساعدة للفئات المحتاجة في رمضان من خلال جمع التبرعات وتنظيم عملية التحضير والتوزيع.", "audiance":"الأسر ذات الدخل المحدود في الأحياء ذات الاحتياجات الخاصة خلال شهر رمضان."},
  {"title": "صدقة جارية", "ets": "قلوب محسنة", "done": 78.0, "details":"مشروع الصدقة الجارية يهدف لمساعدة المحتاجين من خلال مشاريع مستدامة تعود بالنفع على المجتمع.", "audiance":"الفئات المحتاجة في المجتمع بشكل عام."},
  {"title": "زكاة", "ets": "قلوب محسنة", "done": 92.0, "details":"جمع وتوزيع الزكاة على مستحقيها وفقاً للشريعة الإسلامية.", "audiance":"مستحقي الزكاة حسب الشروط الشرعية."},
  {"title": "كسوة العيد", "ets": "قلوب محسنة", "done": 23.0, "details":"توفير ملابس العيد للأطفال من الأسر المحتاجة.", "audiance":"الأطفال من الأسر ذات الدخل المحدود."},
  {"title": "سقيا الماء", "ets": "قلوب محسنة", "done": 67.0, "details":"توفير مياه نظيفة للمناطق المحتاجة من خلال حفر الآبار وتركيب محطات تحلية.", "audiance":"المناطق التي تعاني من نقص المياه النظيفة."},
  {"title": "تعليم", "ets": "قلوب محسنة", "done": 88.0, "details":"دعم الطلاب المحتاجين في مسيرتهم التعليمية من خلال توفير المستلزمات الدراسية.", "audiance":"الطلاب من الأسر ذات الدخل المحدود."},
  {"title": "علاج مريض", "ets": "قلوب محسنة", "done": 45.0, "details":"مساعدة المرضى المحتاجين في تكاليف العلاج والأدوية.", "audiance":"المرضى غير القادرين على تحمل تكاليف العلاج."},
  {"title": "بناء مسجد", "ets": "قلوب محسنة", "done": 34.0, "details":"المساهمة في بناء وتعمير المساجد في المناطق المحتاجة.", "audiance":"المجتمعات التي تحتاج إلى دور عبادة."},
  {"title": "دعم الأرامل", "ets": "قلوب محسنة", "done": 56.0, "details":"تقديم الدعم المادي والمعنوي للأرامل وأسرهن.", "audiance":"الأرامل وأطفالهن."},
  {"title": "إغاثة عاجلة", "ets": "قلوب محسنة", "done": 89.0, "details":"تقديم المساعدات العاجلة للمتضررين من الكوارث والأزمات.", "audiance":"المتضررون من الكوارث الطبيعية والأزمات."},
  {"title": "دعم المعاقين", "ets": "قلوب محسنة", "done": 67.0, "details":"توفير الأجهزة والمعدات اللازمة لذوي الاحتياجات الخاصة.", "audiance":"ذوو الاحتياجات الخاصة من الأسر المحتاجة."},
  {"title": "تأهيل مهني", "ets": "قلوب محسنة", "done": 45.0, "details":"تدريب وتأهيل الشباب المحتاج لسوق العمل.", "audiance":"الشباب الباحثون عن عمل من الأسر المحتاجة."},
  {"title": "دعم الأسر المنتجة", "ets": "قلوب محسنة", "done": 78.0, "details":"دعم المشاريع الصغيرة للأسر المحتاجة لتحقيق الاكتفاء الذاتي.", "audiance":"الأسر المحتاجة القادرة على العمل والإنتاج."},
  {"title": "ترميم منازل", "ets": "قلوب محسنة", "done": 56.0, "details":"ترميم وإصلاح منازل الأسر المحتاجة.", "audiance":"الأسر التي تعيش في منازل متهالكة."},
  {"title": "كفارة يمين", "ets": "قلوب محسنة", "done": 90.0, "details":"توزيع كفارات اليمين على المحتاجين وفق الشريعة.", "audiance":"الفقراء والمساكين المستحقين للكفارة."},
  {"title": "وقف خيري", "ets": "قلوب محسنة", "done": 34.0, "details":"إنشاء أوقاف خيرية تعود بالنفع على المجتمع.", "audiance":"عموم المجتمع المستفيد من الوقف."},
  {"title": "رعاية مسنين", "ets": "قلوب محسنة", "done": 67.0, "details":"تقديم الرعاية والدعم لكبار السن المحتاجين.", "audiance":"كبار السن المحتاجون للرعاية."},
  {"title": "دعم طلاب العلم", "ets": "قلوب محسنة", "done": 45.0, "details":"دعم طلاب العلم الشرعي في مسيرتهم التعليمية.", "audiance":"طلاب العلم الشرعي المحتاجون."},
  {"title": "إفطار صائم", "ets": "قلوب محسنة", "done": 88.0, "details":"توفير وجبات إفطار للصائمين في المساجد والأماكن العامة.", "audiance":"الصائمون في شهر رمضان."}
];
