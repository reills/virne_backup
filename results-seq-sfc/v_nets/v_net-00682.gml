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
  id 682
  arrival_time 14431.357072575618
  lifetime 678.6492771114393
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 32
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 36
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 13
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 35
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 12
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 14
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 33
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 36
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 12
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 35
    rom 32
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 8
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 46
    gpu 31
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
]
