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
  id 83
  arrival_time 1641.077575780279
  lifetime 460.075790074759
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 20
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 29
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 48
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 9
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
]
