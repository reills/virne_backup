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
  id 905
  arrival_time 19341.658530350323
  lifetime 713.8658344909463
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 10
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 33
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 32
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 3
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
]
