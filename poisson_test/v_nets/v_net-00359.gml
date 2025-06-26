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
  id 359
  arrival_time 6842.60114213522
  lifetime 2219.2248046005684
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 40
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 43
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 43
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 17
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 9
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 2
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 12
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 43
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 3
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 24
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 49
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 26
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 45
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
]
