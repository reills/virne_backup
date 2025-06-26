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
  id 937
  arrival_time 20022.54720017546
  lifetime 381.3306579713434
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 8
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 4
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 17
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 38
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 41
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 44
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 30
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 15
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 12
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 7
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 21
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 48
    gpu 31
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 9
    gpu 40
    rom 4
  ]
  node [
    id 13
    label "13"
    cpu 8
    gpu 25
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
  edge [
    source 12
    target 13
    bw 49
  ]
]
