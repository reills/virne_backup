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
  id 1637
  arrival_time 36661.57080052233
  lifetime 101.03986896414779
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 42
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 20
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 30
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 1
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 1
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 3
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 19
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 44
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
]
