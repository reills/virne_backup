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
  id 1537
  arrival_time 33979.68937398706
  lifetime 936.4319653519173
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 27
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 41
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 4
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 28
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 17
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 8
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 45
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 11
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 27
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 7
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
]
