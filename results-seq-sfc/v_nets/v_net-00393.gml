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
  id 393
  arrival_time 7817.962655049062
  lifetime 397.0619195816128
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 2
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 39
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 33
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 35
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 28
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 22
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
]
