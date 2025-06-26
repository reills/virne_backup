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
  id 542
  arrival_time 10279.57100584495
  lifetime 1831.1392465317572
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 41
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 33
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 13
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 43
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 23
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 40
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 17
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 42
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 50
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 36
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 34
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 22
    gpu 19
    rom 7
  ]
  node [
    id 12
    label "12"
    cpu 50
    gpu 7
    rom 28
  ]
  node [
    id 13
    label "13"
    cpu 38
    gpu 22
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 15
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 31
  ]
  edge [
    source 12
    target 13
    bw 38
  ]
]
