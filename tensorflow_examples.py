'''
https://chromium.googlesource.com/external/github.com/tensorflow/tensorflow/+/r0.7/tensorflow/g3doc/tutorials/mnist/download/index.md
https://colab.research.google.com/github/tensorflow/docs/blob/master/site/en/r2/tutorials/quickstart/beginner.ipynb#scrollTo=F7dTAzgHDUh7
https://www.tensorflow.org/alpha/guide/keras/functional
'''

from __future__ import absolute_import, division, print_function, unicode_literals
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers


# from https://colab.research.google.com/github/tensorflow/docs/blob/master/site/en/r2/tutorials/quickstart/beginner.ipynb#scrollTo=7NAbSZiaoJ4z
def beginnerExample():
	mnist = tf.keras.datasets.mnist
	(x_train, y_train), (x_test, y_test) = mnist.load_data()
	x_train, x_test = x_train / 255.0, x_test / 255.0
	
	model = tf.keras.models.Sequential(
			[tf.keras.layers.Flatten(input_shape=(28, 28)),
			tf.keras.layers.Dense(128, activation='relu'),
			tf.keras.layers.Dropout(0.2),
			tf.keras.layers.Dense(10, activation='softmax')]
	)
	
	model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',metrics=['accuracy'])
	model.fit(x_train, y_train, epochs=5)
	model.evaluate(x_test, y_test)


	
#From https://www.tensorflow.org/alpha/guide/keras/functional
def kerasExample():	
	inputs = keras.Input(shape=(784,), name='img')
	x = layers.Dense(64, activation='relu')(inputs)
	x = layers.Dense(64, activation='relu')(x)
	outputs = layers.Dense(10, activation='softmax')(x)

	model = keras.Model(inputs=inputs, outputs=outputs, name='mnist_model')

	(x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()
	x_train = x_train.reshape(60000, 784).astype('float32') / 255
	x_test = x_test.reshape(10000, 784).astype('float32') / 255

	model.compile(loss='sparse_categorical_crossentropy',
		      optimizer=keras.optimizers.RMSprop(),
		      metrics=['accuracy'])
	history = model.fit(x_train, y_train,
			    batch_size=64,
			    epochs=5,
			    validation_split=0.2)
	test_scores = model.evaluate(x_test, y_test, verbose=0)
	print('Test loss:', test_scores[0])
	print('Test accuracy:', test_scores[1])

def naiveBayes():
	(x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()
	x_train = x_train.reshape(60000, 784).astype('float32') / 255
	x_test = x_test.reshape(10000, 784).astype('float32') / 255
	
	#Convert grayscale to Zero and One
	for imgIdx in range(len(x_train)):
		for pxlIdx in range(len(x_train[0])):
			x_train[imgIdx][pxlIdx] = 1 if x_train[imgIdx][pxlIdx] > 0.1 else 0
	for imgIdx in range(len(x_test)):
		for pxlIdx in range(len(x_test[0])):
			x_test[imgIdx][pxlIdx] = 1 if x_test[imgIdx][pxlIdx] > 0.1 else 0
	
naiveBayes()
#kerasExample()
#beginnerExample()

