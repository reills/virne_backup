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
  id 946
  arrival_time 20265.79367372188
  lifetime 739.0893835371675
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 37
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 33
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 27
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 31
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 19
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 37
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 16
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 2
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 32
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 16
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 16
    gpu 48
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 16
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 26
  ]
]
