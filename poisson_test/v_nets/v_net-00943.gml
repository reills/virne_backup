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
  id 943
  arrival_time 20110.045402058116
  lifetime 777.5898344660304
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 15
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 50
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 40
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 35
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 11
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
]
