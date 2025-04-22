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
  id 1886
  arrival_time 41559.01118450963
  lifetime 671.4177871648913
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 7
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 20
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 49
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 6
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 11
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 44
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 33
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 8
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 39
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 44
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 27
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 9
    rom 42
  ]
  node [
    id 12
    label "12"
    cpu 48
    gpu 37
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 1
  ]
  edge [
    source 10
    target 11
    bw 12
  ]
  edge [
    source 11
    target 12
    bw 36
  ]
]
