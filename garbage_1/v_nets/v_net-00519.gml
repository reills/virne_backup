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
  id 519
  arrival_time 9866.872834622047
  lifetime 2029.9510274049587
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 6
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 41
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 46
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 9
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 27
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 25
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
]
