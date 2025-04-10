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
  id 235
  arrival_time 4240.474283168487
  lifetime 285.4668526487544
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 12
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 28
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 23
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 6
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 28
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 44
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 47
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 18
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 32
    rom 46
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 39
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 35
    gpu 15
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 8
    gpu 50
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 9
    gpu 28
    rom 49
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 5
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
  edge [
    source 11
    target 12
    bw 9
  ]
  edge [
    source 12
    target 13
    bw 8
  ]
]
