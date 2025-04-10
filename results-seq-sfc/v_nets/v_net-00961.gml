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
  id 961
  arrival_time 20445.42007044484
  lifetime 351.6217801055927
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 45
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 36
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 44
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 27
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 49
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 25
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 41
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 35
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 24
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
]
