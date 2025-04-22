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
  id 1876
  arrival_time 41396.49700780201
  lifetime 2120.4892322886526
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 46
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 20
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 3
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 27
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 49
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 22
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 14
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 4
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 4
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 45
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 11
    gpu 0
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
]
