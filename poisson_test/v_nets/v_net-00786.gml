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
  id 786
  arrival_time 16193.21382080836
  lifetime 1280.462045150682
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 3
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 5
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 8
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 12
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 43
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 18
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 12
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 31
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 10
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 42
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 45
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 0
    rom 50
  ]
  node [
    id 12
    label "12"
    cpu 49
    gpu 13
    rom 35
  ]
  node [
    id 13
    label "13"
    cpu 29
    gpu 34
    rom 49
  ]
  node [
    id 14
    label "14"
    cpu 44
    gpu 35
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 40
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 34
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
  edge [
    source 13
    target 14
    bw 25
  ]
]
