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
  id 780
  arrival_time 16174.152110319767
  lifetime 356.63532175166046
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 0
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 17
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 33
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 16
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 36
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 18
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 21
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
]
