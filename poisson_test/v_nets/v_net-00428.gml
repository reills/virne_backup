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
  id 428
  arrival_time 8367.739398722691
  lifetime 415.8166572794811
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 2
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 43
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 39
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 42
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 29
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
]
