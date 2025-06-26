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
  id 1213
  arrival_time 25230.02714013464
  lifetime 495.6746728298512
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 46
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 24
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 28
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 16
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 25
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 39
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
]
