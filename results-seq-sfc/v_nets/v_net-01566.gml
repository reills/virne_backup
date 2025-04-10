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
  id 1566
  arrival_time 35016.47240543617
  lifetime 2660.6089945298822
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 30
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 49
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 30
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 28
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 28
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 9
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 36
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 50
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 32
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 32
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
]
