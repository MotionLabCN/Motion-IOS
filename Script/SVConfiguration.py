# coding: utf-8
import os,sys,shutil,optparse


scheme = 'Motion'
script_dir = 'Script'

devIconPath = script_dir + '/dev/AppIcon.appiconset'
productionIconPath = script_dir + '/production/AppIcon.appiconset'
currentIconPath = scheme + '/Assets.xcassets/AppIcon.appiconset'

configPath =  scheme + "/config.swift"
r_configPath =  scheme + "/r_config.swift"

devLine = '    static var isForAppStore: Bool = false'
productionLine = '    static var isForAppStore: Bool = true'




def setTheDevAppIcon():
	print(devIconPath)
	if os.path.isdir(currentIconPath) and os.path.isdir(devIconPath):
		print(2)
		shutil.rmtree(currentIconPath)
		shutil.copytree(devIconPath,currentIconPath)


def setTheProductionAppIcon():
	if os.path.isdir(currentIconPath) and os.path.isdir(productionIconPath):
		shutil.rmtree(currentIconPath)
		shutil.copytree(productionIconPath,currentIconPath)


def replaceConfiguration(str1,str2):
	print("准备替换图标")
	if os.path.isfile(configPath):
		with open(configPath,mode='r',encoding='utf-8') as fr,open(r_configPath,mode='w',encoding='utf-8') as fw:
			for line in fr:
				fw.write(line.replace(str1,str2))
		os.remove(configPath)
		os.rename(r_configPath,configPath)



def setDev():
	replaceConfiguration(productionLine,devLine)
	setTheDevAppIcon()

def setProduction():
	replaceConfiguration(devLine,productionLine)
	setTheProductionAppIcon()


def changeConfiguration():
	p = optparse.OptionParser()
	p.add_option('--configuration','-c',default='Dev')
	opthions,arguments = p.parse_args()
	print(opthions)

	if opthions.configuration == 'production':
	    setProduction()
	else:
	    setDev()

if __name__ == '__main__':
	changeConfiguration()
