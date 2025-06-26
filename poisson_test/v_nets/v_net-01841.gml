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
  id 1841
  arrival_time 40676.48493633317
  lifetime 1564.2973398564818
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 26
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 44
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 39
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 15
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 23
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 26
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 38
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 19
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 1
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 14
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
]
