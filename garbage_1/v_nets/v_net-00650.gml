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
  id 650
  arrival_time 13699.62565400581
  lifetime 569.943505483237
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 7
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 36
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 33
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 20
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 9
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 46
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 29
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 45
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 47
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 0
    gpu 46
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 25
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 45
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 1
  ]
]
