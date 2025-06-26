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
  id 1639
  arrival_time 36662.94074175111
  lifetime 2025.8271377316696
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 11
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 31
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 24
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 29
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 29
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 35
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 3
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 46
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 1
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 50
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 0
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 8
    rom 42
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 34
    rom 11
  ]
  node [
    id 13
    label "13"
    cpu 3
    gpu 4
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 42
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
]
