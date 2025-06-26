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
  id 649
  arrival_time 13684.517715233733
  lifetime 1690.9867969153897
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 11
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 49
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 2
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 46
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 18
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 45
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 16
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 37
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 49
    rom 25
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 26
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 32
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 18
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 31
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
]
