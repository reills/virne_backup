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
  id 764
  arrival_time 16056.447758739685
  lifetime 1129.0620240524736
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 39
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 48
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 45
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 5
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 15
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 4
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 26
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 50
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 49
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 18
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 45
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 50
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 37
    gpu 17
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 44
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
]
