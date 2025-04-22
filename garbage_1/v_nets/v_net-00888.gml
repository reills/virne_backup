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
  id 888
  arrival_time 18793.237092399417
  lifetime 39.598946173671905
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 21
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 45
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 1
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 15
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 25
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 10
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
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
]
