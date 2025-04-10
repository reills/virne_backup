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
  id 168
  arrival_time 3160.370663170626
  lifetime 150.32035615434373
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 18
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 34
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 46
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 43
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 39
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 5
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 42
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 38
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 40
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 46
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 33
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 32
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 34
    gpu 21
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
]
