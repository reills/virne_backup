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
  id 1000
  arrival_time 21325.143597140046
  lifetime 376.03929321599
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 21
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 1
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 6
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 23
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 10
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 27
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 12
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 35
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 23
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 46
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 26
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 13
    rom 16
  ]
  node [
    id 12
    label "12"
    cpu 26
    gpu 20
    rom 40
  ]
  node [
    id 13
    label "13"
    cpu 41
    gpu 46
    rom 1
  ]
  node [
    id 14
    label "14"
    cpu 26
    gpu 22
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 49
  ]
  edge [
    source 13
    target 14
    bw 10
  ]
]
