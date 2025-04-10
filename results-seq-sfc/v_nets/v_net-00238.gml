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
  id 238
  arrival_time 4403.832065184572
  lifetime 206.72378488490241
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 13
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 7
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 41
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 11
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 9
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 44
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 47
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 9
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 13
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 32
    rom 39
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 11
    rom 39
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 36
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 7
    gpu 35
    rom 42
  ]
  node [
    id 13
    label "13"
    cpu 31
    gpu 47
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 17
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
  edge [
    source 11
    target 12
    bw 19
  ]
  edge [
    source 12
    target 13
    bw 18
  ]
]
