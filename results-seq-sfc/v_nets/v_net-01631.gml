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
  id 1631
  arrival_time 36574.03026996536
  lifetime 890.4819928138038
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 23
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 25
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 10
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 40
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 49
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 0
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 28
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 20
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 24
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 4
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 32
    rom 19
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 1
    rom 36
  ]
  node [
    id 12
    label "12"
    cpu 41
    gpu 49
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 37
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
]
