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
  id 446
  arrival_time 8578.19767765878
  lifetime 1723.1850747684532
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 17
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 1
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 25
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 13
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 47
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 30
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 26
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
]
