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
  id 935
  arrival_time 20013.81535547704
  lifetime 758.2491476892012
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 14
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 39
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 11
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 25
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 28
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 21
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 27
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 46
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 24
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 15
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 50
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 5
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 29
    rom 32
  ]
  node [
    id 13
    label "13"
    cpu 35
    gpu 21
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 44
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
  edge [
    source 12
    target 13
    bw 46
  ]
]
