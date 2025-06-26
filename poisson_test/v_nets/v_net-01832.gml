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
  id 1832
  arrival_time 40484.049924016974
  lifetime 423.84681395831916
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 29
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 46
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 0
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 26
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 26
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 4
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 34
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 25
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 9
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 24
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 24
    rom 39
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 7
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 50
    gpu 41
    rom 21
  ]
  node [
    id 13
    label "13"
    cpu 19
    gpu 46
    rom 7
  ]
  node [
    id 14
    label "14"
    cpu 11
    gpu 14
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 10
  ]
  edge [
    source 12
    target 13
    bw 27
  ]
  edge [
    source 13
    target 14
    bw 48
  ]
]
