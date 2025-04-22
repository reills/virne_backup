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
  id 775
  arrival_time 16166.511299101096
  lifetime 431.02614435223074
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 10
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 35
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 44
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 32
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 6
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 17
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 43
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 22
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 48
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 15
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 44
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 25
    gpu 21
    rom 41
  ]
  node [
    id 12
    label "12"
    cpu 49
    gpu 47
    rom 14
  ]
  node [
    id 13
    label "13"
    cpu 49
    gpu 35
    rom 15
  ]
  node [
    id 14
    label "14"
    cpu 5
    gpu 31
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
  edge [
    source 12
    target 13
    bw 44
  ]
  edge [
    source 13
    target 14
    bw 23
  ]
]
