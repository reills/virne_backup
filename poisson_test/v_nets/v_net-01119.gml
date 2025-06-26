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
  id 1119
  arrival_time 23282.197415043247
  lifetime 200.03345499074794
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 46
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 5
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 12
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 35
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 26
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 26
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 19
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 30
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 21
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 26
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 14
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
]
