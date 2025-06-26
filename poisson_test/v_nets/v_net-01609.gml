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
  id 1609
  arrival_time 36046.62556291242
  lifetime 504.21958115971756
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 11
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 22
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 1
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 39
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 22
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 39
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 33
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 43
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 17
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 50
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 24
    rom 44
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 19
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 20
    gpu 4
    rom 42
  ]
  node [
    id 13
    label "13"
    cpu 42
    gpu 2
    rom 16
  ]
  node [
    id 14
    label "14"
    cpu 9
    gpu 1
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
  edge [
    source 11
    target 12
    bw 24
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
  edge [
    source 13
    target 14
    bw 47
  ]
]
