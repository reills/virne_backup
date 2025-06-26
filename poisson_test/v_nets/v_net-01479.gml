graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1479
  arrival_time 32142.028552050873
  lifetime 1839.613420870999
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 41
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 41
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
]
