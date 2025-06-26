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
  id 749
  arrival_time 15898.722288969335
  lifetime 94.77253106273193
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 9
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 26
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 37
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 19
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 31
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 24
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 37
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 6
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 14
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 37
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 15
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 1
    gpu 11
    rom 3
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 38
    rom 1
  ]
  node [
    id 13
    label "13"
    cpu 9
    gpu 2
    rom 42
  ]
  node [
    id 14
    label "14"
    cpu 41
    gpu 34
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 14
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
  edge [
    source 12
    target 13
    bw 35
  ]
  edge [
    source 13
    target 14
    bw 29
  ]
]
