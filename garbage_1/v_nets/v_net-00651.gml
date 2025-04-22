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
  id 651
  arrival_time 13802.562918694934
  lifetime 1743.053190078046
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 0
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 18
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 50
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 24
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 28
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 42
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 29
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 6
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 32
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 32
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 16
    gpu 38
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 30
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
]
