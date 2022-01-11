
public class VentanaPrincipal extends JFrame implements ActionListener {

  private Container contenedor;
  JButton botonCambiar;
  JLabel labelTitulo;

private VentanaPrincipal miVentanaPrincipal;

public VentanaPrincipal(){
  iniciarComponentes();
  setTitle("Título de la ventana");
  setSize(300,180);
  setLocationRelativeTo(null);
}

private void iniciarComponentes() {
  contenedor=getContentPane();
  contenedor.setLayout(null);

  botonCambiar= new JButton();
  botonCambiar.setText("Cambiar texto");
  botonCambiar.setBounds(100, 80, 80, 23);
  botonCambiar.addActionListener(this);

  labelTitulo= new JLabel();
  labelTitulo.setText("¡Hola!");
  labelTitulo.setBounds(80, 20, 180, 23);

  contenedor.add(labelTitulo);
  contenedor.add(botonCambiar);
 }

  public void actionPerformed(ActionEvent evento) {
    if (evento.getSource()==botonCambiar) {
      labelTitulo.setText("¡Adios!");
    }
  }
}
