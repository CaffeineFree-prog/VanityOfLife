
import java.util.List;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

public class Configurer extends PropertyPlaceholderConfigurer {
	
	private static Properties properties;
	private static List<String> encryptedProperties;
	
	public static List<String> getEncryptedProperties() {
		return encryptedProperties;
	}

	public void setEncryptedProperties(List<String> encryptedProperties) {
		Configurer.encryptedProperties = encryptedProperties;
	}
	
	public static boolean isEncryptedProperty(String key) {
		return encryptedProperties != null && encryptedProperties.contains(key);
	}
	
	@Override
	protected String convertProperty(String key, String strValue) {
		
		String value = strValue;
		if (isEncryptedProperty(key) && value != null) {
			System.out.println("key : " + key);
			System.out.println("value : " + strValue);
			
			if ("login.jdbc.password".equals(key)) {
				value = "";
			} else if ("jdbc.password".equals(key)) {
				value = "";
			}
			
			System.out.println("strValue : " + value);
		}
		return super.convertProperty(key, value);
	}
	
	@Override
	protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess, Properties props)
			throws BeansException {
		System.out.println("!!!!!!!!!!!!!!!!!!!");
		super.processProperties(beanFactoryToProcess, props);
		
		if (properties == null) {
			properties = props;
		} else {
			properties.putAll(props);
		}
		System.out.println("properties info = " + properties);
	}
}


<bean class="com.ecvan.core.config.Configurer">
	<property name="locations">
		<value>/WEB-INF/config/jdbc.properties</value>
	</property>
	<property name="encryptedProperties">
		<list>
			<value>jdbc.password</value>
			<value>login.jdbc.password</value>
		</list>
	</property>
</bean>
