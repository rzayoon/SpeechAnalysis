# SpeechAnalysis

음성에서 추출한 feature를 토대로 재합성한다.

음성 전체를 짧은 간격의 frame들로 분할하며 각 frame은 인접한 frame과 일정한 중복 구간을 가진다.

분할된 각각의 frame은 관심영역 외의 정보를 최소화하기 위해 hamming windowing하며,
추출된 feature로 LPC(Linear Prediction Coefficients), Zero Crossing rate, Energy, Pitch의 값들을 가진다.

LPC는 특정 구간의 짧은 음성 신호를 p개 신호의 선형 결합으로 예측할 수 있음을 기본 아이디어로 한다.
주로 Levinson Durvin 알고리즘을 통해 구해지며,
결과적으로 p개의 계수는 유성음 프레임에서 주기적으로 반복되는 formant frequency의 정보를 갖게 된다.

그런데, LPC는 안정성이 떨어진다.
이는 전송 과정에서 약간의 noise로도 파형을 망가지게 될 위험이 크다는 것을 의미한다.
따라서 이 값들을 양자화하여 표현할 필요가 있다.
이를 위해 LPC를 Line Spectral Frequency로 변형시킨다. 

Zero Crossing rate(영교차점)와 Energy는 주로 각 프레임이 유성음인지 무성음인지 구분한다.
영교차점이 많을수록 규칙성이 없음을 의미하므로 무성음일 확률이 높고
신호 진폭의 합계를 표현하는 Energy는 무성음에 비해 진폭이 큰 유성음에서 높은 값을 가진다.

Pitch는 AMDF 알고리즘을 활용하여 얻는다.

이 코드에서는 Voiced/Unvoiced의 구별하는 정확성을 높이기 위해 일반적인 Pitch 값을 벗어나는 경우도 구별점으로 두었다.
