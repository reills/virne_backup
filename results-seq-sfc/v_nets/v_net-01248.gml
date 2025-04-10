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
  id 1248
  arrival_time 25894.157649617217
  lifetime 5798.848395177918
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 41
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 20
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 49
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
]
